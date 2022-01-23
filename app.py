import pandas as pd
import numpy as np
from flask import Flask, request, jsonify
from model import get_dollar_estimate
app = Flask(__name__)


@app.route('/')
def index():
    return jsonify('Hello welcome to server!')


def ValuePredictor(to_predict_list):
    chas = False
    if to_predict_list['CHAS'] == 'True':
        chas = True
    else:
        chas = False
    conf = False
    if to_predict_list['CONF'] == 'True':
        conf = True
    else:
        conf = False
    result = get_dollar_estimate(int(to_predict_list['RM']), int(
        to_predict_list['PTRATIO']), chas, conf)
    return result


@app.route('/predict', methods=['POST'])
def result():
    if request.method == 'POST':
        to_predict_list = request.form.to_dict()
        result = ValuePredictor(to_predict_list)
        prediction = str(result[0])
        prediction_high = str(result[1])
        prediction_low = str(result[2])
        confidence = str(result[3])
        return jsonify({'prediction':prediction,'prediction_high':prediction_high,'prediction_low':prediction_low,'confidence':confidence})


if __name__ == '__main__':
    app.run(debug=True)
