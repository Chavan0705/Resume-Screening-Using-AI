import os
import sys
import pandas as pd

# Add root folder to sys.path so we can import utils
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from utils.preprocess_text import clean_resume_text

def load_and_clean_data(file_path):
    print("Loading dataset from:", file_path)
    df = pd.read_csv(file_path)
    
    print("Original dataset shape:", df.shape)
    # Deduplicate
    df_clean = df.drop_duplicates(keep='first').copy()
    print("Deduplicated dataset shape:", df_clean.shape)
    
    # Preprocess text
    print("Cleaning resume text...")
    df_clean['Cleaned_Resume'] = df_clean['Resume'].apply(clean_resume_text)
    
    return df_clean

if __name__ == '__main__':
    dataset_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '../dataset/UpdatedResumeDataSet.csv'))
    df = load_and_clean_data(dataset_path)
    output_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '../dataset/CleanedResumeDataSet.csv'))
    df.to_csv(output_path, index=False)
    print("Preprocessed data saved to:", output_path)
