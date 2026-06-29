import re
import string
import nltk
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer

# Download NLTK data quietly if not present
try:
    nltk.data.find('corpora/stopwords')
except LookupError:
    nltk.download('stopwords', quiet=True)

try:
    nltk.data.find('corpora/wordnet')
except LookupError:
    nltk.download('wordnet', quiet=True)

try:
    nltk.data.find('tokenizers/punkt')
except LookupError:
    nltk.download('punkt', quiet=True)

try:
    nltk.data.find('corpora/omw-1.4')
except LookupError:
    nltk.download('omw-1.4', quiet=True)

def clean_resume_text(text):
    if not isinstance(text, str):
        text = str(text) if text is not None else ""
    # Remove non-ASCII characters (cleaning bullets, symbols, etc.)
    text = re.sub(r'[^\x00-\x7f]+', ' ', text)
    # Lowercase conversion
    text = text.lower()
    # Remove URLs
    text = re.sub(r'https?://\S+|www\.\S+', ' ', text)
    # Remove email addresses
    text = re.sub(r'\S+@\S+', ' ', text)
    # Remove RT and CC common headers
    text = re.sub(r'\brt\b|\bcc\b', ' ', text)
    # Remove mentions/hashtags
    text = re.sub(r'#\S+|@\S+', ' ', text)
    # Remove punctuation (replace with space to prevent merging words)
    text = text.translate(str.maketrans(string.punctuation, ' ' * len(string.punctuation)))
    # Remove numbers
    text = re.sub(r'\d+', ' ', text)
    
    # Tokenization, stopword removal and lemmatization
    stop_words = set(stopwords.words('english'))
    lemmatizer = WordNetLemmatizer()
    
    words = text.split()
    cleaned_words = [
        lemmatizer.lemmatize(w) for w in words 
        if w not in stop_words and len(w) > 2
    ]
    return ' '.join(cleaned_words)
