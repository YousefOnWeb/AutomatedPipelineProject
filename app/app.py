from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html', title="Home")

@app.route('/process', methods=['POST'])
def process():
    user_input = request.form.get('input_text', '').strip()
    if user_input:
        result = f"You entered: {user_input}"
    else:
        result = "You didn't enter anything. Please try again!"
    return render_template('result.html', title="Result", result=result)

if __name__ == '__main__':
    app.run(debug=True)
