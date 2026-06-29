import os
import sys
import pandas as pd
import joblib
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report, accuracy_score

# Add root folder to sys.path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

def evaluate():
    api_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    model_path = os.path.join(api_dir, 'model.pkl')
    vectorizer_path = os.path.join(api_dir, 'vectorizer.pkl')
    le_path = os.path.join(api_dir, 'label_encoder.pkl')
    
    if not (os.path.exists(model_path) and os.path.exists(vectorizer_path) and os.path.exists(le_path)):
        print("Error: Pickle files not found. Run training/train_model.py first.")
        return

    # Load pickles
    print("Loading pickles...")
    model = joblib.load(model_path)
    vectorizer = joblib.load(vectorizer_path)
    label_encoder = joblib.load(le_path)
    
    # Load dataset
    cleaned_data_path = os.path.join(api_dir, 'dataset/CleanedResumeDataSet.csv')
    if not os.path.exists(cleaned_data_path):
        from training.preprocess import load_and_clean_data
        dataset_path = os.path.join(api_dir, 'dataset/UpdatedResumeDataSet.csv')
        df = load_and_clean_data(dataset_path)
    else:
        df = pd.read_csv(cleaned_data_path)
    
    # Encode targets
    df['Category_Encoded'] = label_encoder.transform(df['Category'])
    
    # Vectorize
    X = vectorizer.transform(df['Cleaned_Resume']).toarray()
    y = df['Category_Encoded'].values
    
    # Train-test split
    _, X_test, _, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42, stratify=y
    )
    
    # Predict
    print("Evaluating model...")
    y_pred = model.predict(X_test)
    
    # Print metrics
    acc = accuracy_score(y_test, y_pred)
    print(f"Accuracy Score: {acc * 100:.2f}%")
    print("\nClassification Report:")
    print(classification_report(y_test, y_pred, target_names=label_encoder.classes_, zero_division=0))

if __name__ == '__main__':
    evaluate()
