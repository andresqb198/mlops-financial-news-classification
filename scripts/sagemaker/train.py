import os
import argparse
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
import joblib

if __name__=='__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--data-path',
                        type=str,
                        default='/opt/ml/input/data/train')
    
    parser.add_argument('--model-dir',
                        type=str,
                        default='/opt/ml/model')
    
    args = parser.parse_args()

    data_file = os.path.join(args.data_path, 'train_transformed.parquet')
    df = pd.read_parquet(data_file)
    
    vectorizer = TfidfVectorizer()
    X = vectorizer.fit_transform(df['text_clean'])
    y = df['polarity'].astype(int)
    
    clf = LogisticRegression()
    clf.fit(X, y)
    
    os.makedirs(args.model_dir, exist_ok=True)
    joblib.dump(clf, os.path.join(args.model_dir, 'model.joblib'))
    joblib.dump(vectorizer, os.path.join(args.model_dir, 'vectorizer.joblib'))
