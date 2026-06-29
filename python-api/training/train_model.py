import os
import sys
import pandas as pd
import joblib
from sklearn.preprocessing import LabelEncoder
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier

# Add root folder to sys.path so we can import utils and training
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from training.preprocess import load_and_clean_data

def train():
    dataset_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '../dataset/UpdatedResumeDataSet.csv'))
    
    # Load and preprocess data
    df = load_and_clean_data(dataset_path)
    
    # Target Encoding
    print("Encoding target categories...")
    label_encoder = LabelEncoder()
    df['Category_Encoded'] = label_encoder.fit_transform(df['Category'])
    
    # Feature Extraction (TF-IDF)
    print("Vectorizing resume text using TF-IDF...")
    vectorizer = TfidfVectorizer(max_features=3000)
    X = vectorizer.fit_transform(df['Cleaned_Resume']).toarray()
    y = df['Category_Encoded'].values
    
    # Train-test split (stratified)
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42, stratify=y
    )
    
    # Train Random Forest Classifier
    print("Training Random Forest Classifier...")
    model = RandomForestClassifier(n_estimators=100, random_state=42)
    model.fit(X_train, y_train)
    
    # Evaluate basic train/test score
    train_acc = model.score(X_train, y_train)
    test_acc = model.score(X_test, y_test)
    print(f"Train Accuracy: {train_acc:.4f}")
    print(f"Test Accuracy: {test_acc:.4f}")
    
    # Save artifacts
    api_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    model_path = os.path.join(api_dir, 'model.pkl')
    vectorizer_path = os.path.join(api_dir, 'vectorizer.pkl')
    le_path = os.path.join(api_dir, 'label_encoder.pkl')
    
    print("Saving pickles to python-api...")
    joblib.dump(model, model_path)
    joblib.dump(vectorizer, vectorizer_path)
    joblib.dump(label_encoder, le_path)
    print("Pickles saved successfully!")

if __name__ == '__main__':
    train()
