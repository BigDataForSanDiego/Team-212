from openai import OpenAI
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier


client = OpenAI()

def read_transcript(file_path):
    with open(file_path, 'r') as file:
        return file.read()
    
transcript_path = 'test.txt' 
transcript_content = read_transcript(transcript_path)

completion = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=[
        {"role": "system", "content": "You are a doctor whose only job is to use the transcript from a meeting between a doctor and a patient and create an official medical record."},
        {
            "role": "user",
            "content": transcript_content
        }
    ]
)

print(completion.choices[0].message.content.strip())


data = {
    'smoking': [1, 0, 1, 0, 1],  
    'difficulty_breathing': [1, 0, 1, 0, 1],  
    'chest_tightness': [0, 0, 1, 0, 1],
    'lightheadedness': [1, 0, 1, 1, 1],
    'asthma_risk': [2, 0, 3, 1, 3]  
}

df = pd.DataFrame(data)

X = df.drop('asthma_risk', axis=1)
y = df['asthma_risk']

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

new_patient = np.array([[1, 1, 0, 1]])  # Smoker, difficulty breathing, no chest tightness, lightheadedness

risk_prediction = model.predict(new_patient)[0]

risk_levels = {0: "No Risk", 1: "Low Risk", 2: "Mild Risk", 3: "High Risk"}
predicted_risk_level = risk_levels[risk_prediction]

predicted_risk_level
