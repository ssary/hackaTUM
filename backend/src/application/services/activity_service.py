from datetime import datetime
from src.infrastructure.database import activity_collection
from bson import ObjectId
from utils.openai_api_calls import create_chat_completion
import openai
import os
import random

client = openai.Client(api_key=os.getenv("OPENAI_API_KEY"))

async def get_available_activities():
    current_time = datetime.now().timestamp()
    available_activities = []

    async for activity in activity_collection.find():
        end_time = activity["timerange"]["endTime"]

        if (
            current_time < end_time and
            len(activity["joinedUsers"]) > 0 and
            len(activity["joinedUsers"]) < activity["maxUsers"]
        ):
            activity["id"] = str(activity["_id"])
            del activity["_id"]
            available_activities.append(activity)

    return available_activities

async def get_top_K_similar_activities(activity_id: str, K: int):
    available_activities = get_available_activities()

    # randomize the available activities to not depend on the order
    random.shuffle(available_activities)

    matched_activities = []
    current_activity = await activity_collection.find_one({"_id": ObjectId(activity_id)})
    current_activity["id"] = str(current_activity["_id"])
    del current_activity["_id"]


    # calculate similarity with the current activity
    # Get the top K first similar activities using gpt-4o-mini
    for activity in available_activities:
        user_1_input = current_activity["description"]
        user_2_input = activity["description"]
        api_response = create_chat_completion(client, user_1_input, user_2_input)
        is_matching = api_response["match_output"]
        if is_matching:
            activity["id"] = str(activity["_id"])
            del activity["_id"]
            matched_activities.append(activity)
            if len(matched_activities) == K:
                break
        
    return matched_activities



        
