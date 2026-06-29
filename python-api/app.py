import os
import sys
import joblib
from flask import Flask, request, jsonify

# Add root folder to sys.path
sys.path.append(os.path.abspath(os.path.dirname(__file__)))
from utils.preprocess_text import clean_resume_text

app = Flask(__name__)

# Load model, vectorizer, and label encoder
model_path = os.path.join(os.path.dirname(__file__), 'model.pkl')
vectorizer_path = os.path.join(os.path.dirname(__file__), 'vectorizer.pkl')
le_path = os.path.join(os.path.dirname(__file__), 'label_encoder.pkl')

print("Loading serialized models...")
try:
    model = joblib.load(model_path)
    vectorizer = joblib.load(vectorizer_path)
    label_encoder = joblib.load(le_path)
    print("Models loaded successfully!")
except Exception as e:
    print(f"Error loading model files: {e}")
    model, vectorizer, label_encoder = None, None, None

@app.route('/health', methods=['GET'])
@app.route('/', methods=['GET'])
def health():
    if model and vectorizer and label_encoder:
        return jsonify({"status": "healthy", "model_loaded": True}), 200
    else:
        return jsonify({"status": "unhealthy", "model_loaded": False}), 500

@app.route('/predict', methods=['POST'])
def predict():
    if not (model and vectorizer and label_encoder):
        return jsonify({"error": "Model files are not loaded on server."}), 500
        
    data = request.get_json(silent=True)
    if not data or 'text' not in data:
        return jsonify({"error": "Missing 'text' parameter in request body."}), 400
        
    raw_text = data['text']
    try:
        # Preprocess text
        cleaned = clean_resume_text(raw_text)
        if not cleaned.strip():
            return jsonify({
                "category": "Unknown",
                "confidence": 0.0,
                "warning": "No readable tokens found in text."
            }), 200
            
        # Vectorize text
        features = vectorizer.transform([cleaned]).toarray()
        
        # Predict probability
        prob_dist = model.predict_proba(features)[0]
        max_idx = prob_dist.argmax()
        confidence = float(prob_dist[max_idx])
        predicted_class = label_encoder.classes_[max_idx]
        
        return jsonify({
            "category": predicted_class,
            "confidence": confidence
        }), 200
        
    except Exception as e:
        return jsonify({"error": f"Failed to perform inference: {str(e)}"}), 500

if __name__ == '__main__':
    # Start the Flask API on port 5000
    app.run(host='0.0.0.0', port=5000, debug=True)
