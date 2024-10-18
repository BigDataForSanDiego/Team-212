# import openai


# def chat_with_gpt(prompt):
#     response = openai.chat.completions.create(
#         model="gpt-4o-mini",
#         messages=[{"role": "user", "content": prompt}]
#     )

#     return response.choices[0].message.content.strip()

# if __name__ == "__main__":
#     while True:
#         user_input = input("You: ")
#         if user_input.lower() in ["quit"]:
#             break

#         response = chat_with_gpt(user_input)
#         print("ChatBot: ", response)

from openai import OpenAI

client = OpenAI()

completion = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=[
        {"role": "system", "content": "You are an assistant whose only goal is to agree with the main topic."},
        {
            "role": "user",
            "content": "Pizza, one of the world's most beloved dishes, has a rich and fascinating history that stretches back thousands of years, although the modern pizza as we know it today began in Italy. The origins of pizza can be traced to ancient civilizations like the Greeks, Egyptians, and Romans, who made flatbreads topped with oils, herbs, and sometimes cheese. However, it was in Naples, Italy, during the late 18th and early 19th centuries that pizza began to resemble the dish we are familiar with. Naples, a bustling port city, had a large population of working-class people who needed inexpensive, yet filling food. Street vendors sold flatbreads topped with various ingredients such as garlic, lard, and salt. It was a humble food, often associated with the poor. The turning point for pizza came in 1889 when Queen Margherita of Italy visited Naples. Legend has it that a local pizza maker, Raffaele Esposito, crafted a pizza in her honor using ingredients that represented the colors of the Italian flag: red tomatoes, green basil, and white mozzarella. This pizza, now famously known as the Margherita, helped elevate pizza's status in Italian culture, transforming it from a street food to a dish with national pride. Pizza remained largely an Italian affair until waves of Italian immigrants brought their culinary traditions with them to the United States in the late 19th and early 20th centuries. Pizza began to gain popularity in cities like New York and Chicago, particularly among Italian-American communities. The first documented pizzeria in the U.S. was Lombardi's, which opened in New York City in 1905. As pizza spread across the country, regional variations began to emerge. New York-style pizza, characterized by its large, thin, and flexible slices, became a hit, while in Chicago, deep-dish pizza developed, offering a heartier and thicker version. Following World War II, pizza's popularity exploded as returning American soldiers who had been stationed in Italy brought back a taste for the dish. This post-war boom, combined with the growth of the fast-food industry, made pizza a mainstream American food. Chains like Pizza Hut and Domino's began to emerge in the 1950s and 60s, making pizza more accessible across the United States. These chains further spread pizza's reach globally, turning it into a worldwide phenomenon. Today, pizza has become a global comfort food with endless varieties, from traditional Neapolitan pizzas to experimental versions topped with everything from pineapple to truffle oil. Its adaptability to different cultures and tastes is part of what has made it so enduring. Whether served as a quick slice from a street vendor or in a gourmet restaurant, pizza remains one of the most versatile and popular dishes in the world. From its humble beginnings in the streets of Naples to its status as a global culinary icon, the history of pizza is a story of migration, innovation, and evolution."
        }
    ]
)

print(completion.choices[0].message.content.strip())