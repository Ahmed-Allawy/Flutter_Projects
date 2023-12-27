import io
import json
import logging
from flask_cors import CORS
import base64 

# Imports for the REST API
from flask import Flask, request, jsonify

# Imports for image procesing
from PIL import Image

# Imports for prediction
from predict import initialize, predict_image, predict_url

app = Flask(__name__)
CORS(app)
# 4MB Max image size limit
app.config['MAX_CONTENT_LENGTH'] = 4 * 1024 * 1024


# Default route just shows simple text
@app.route('/')
def index():
    return 'CustomVision.ai model host harness'


# Like the CustomVision.ai Prediction service /image route handles either
#     - octet-stream image file
#     - a multipart/form-data with files in the imageData parameter
@app.route('/image', methods=['POST'])
@app.route('/<project>/image', methods=['POST'])
@app.route('/<project>/image/nostore', methods=['POST'])
@app.route('/<project>/classify/iterations/<publishedName>/image', methods=['POST'])
@app.route('/<project>/classify/iterations/<publishedName>/image/nostore', methods=['POST'])
@app.route('/<project>/detect/iterations/<publishedName>/image', methods=['POST'])
@app.route('/<project>/detect/iterations/<publishedName>/image/nostore', methods=['POST'])
def predict_image_handler(project=None, publishedName=None):
    try:
        # imageData = None
        # if ('imageData' in request.files):
        #     imageData = request.files['imageData']
        # elif ('imageData' in request.form):
        #     imageData = request.form['imageData']
        # else:
        #     imageData = io.BytesIO(request.get_data())

        # img = Image.open(imageData)
        

        if 'image' not in request.json:
            return jsonify({'error': 'No image uploaded'})

        # Get the image data from the request
        image_data = request.json
        image_data = image_data.get('image')
        # # Remove the prefix and decode the base64 data
        # # Decode the base64 image data and convert it to OpenCV format
        # _, encoded_image = image_data.split(",", 1)
        # img = cv2.imdecode(np.frombuffer(base64.b64decode(encoded_image), np.uint8), -1)
        # print(type(img))

            # Remove the data URL scheme from the base64 string
        base64_string = image_data.replace('data:image/png;base64,', '')
        print(base64_string)
        # Decode the base64 string into bytes
        image_bytes = base64.b64decode(base64_string)
        # Create a BytesIO object to wrap the image bytes
        image_buffer = io.BytesIO(image_bytes)

        # Open the image buffer with PIL and return the image
        img = Image.open(image_buffer)
        results = predict_image(img)
        return jsonify(results)
    except Exception as e:
        print('EXCEPTION:', str(e))
        return 'Error processing image', 500


# Like the CustomVision.ai Prediction service /url route handles url's
# in the body of hte request of the form:
#     { 'Url': '<http url>'}
@app.route('/url', methods=['POST'])
@app.route('/<project>/url', methods=['POST'])
@app.route('/<project>/url/nostore', methods=['POST'])
@app.route('/<project>/classify/iterations/<publishedName>/url', methods=['POST'])
@app.route('/<project>/classify/iterations/<publishedName>/url/nostore', methods=['POST'])
@app.route('/<project>/detect/iterations/<publishedName>/url', methods=['POST'])
@app.route('/<project>/detect/iterations/<publishedName>/url/nostore', methods=['POST'])
def predict_url_handler(project=None, publishedName=None):
    try:
        image_url = json.loads(request.get_data().decode('utf-8'))['url']
        results = predict_url(image_url)
        return jsonify(results)
    except Exception as e:
        print('EXCEPTION:', str(e))
        return 'Error processing image'


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)

    # Load and intialize the model
    initialize()

    # Run the server
    app.run(host='0.0.0.0', port=80)
