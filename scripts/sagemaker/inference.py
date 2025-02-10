import sys
import os
import joblib
import pandas as pd

def model_fn(model_dir):
    clf = joblib.load(os.path.join(model_dir, "model.joblib"))
    vectorizer = joblib.load(os.path.join(model_dir, "vectorizer.joblib"))
    return clf, vectorizer

def predict_fn(input_data, model_and_vectorizer):
    clf, vectorizer = model_and_vectorizer
    X = vectorizer.transform(input_data['text_clean'])
    predictions = clf.predict(X)
    return predictions

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python inference.py <model-dir> <input-file>")
        sys.exit(1)
    model_dir = sys.argv[1]
    input_file = sys.argv[2]
    
    model, vectorizer = model_fn(model_dir)
    
    df = pd.read_csv(input_file)
    predictions = predict_fn(df, (model, vectorizer))
    
    df['predictions'] = predictions
    output_file = "inference_results.csv"
    df.to_csv(output_file, index=False)
    
    print(f"Inference completed. Predictions saved to {output_file}")
