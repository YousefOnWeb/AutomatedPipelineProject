import unittest
from app import app

class AppTestCase(unittest.TestCase):
    def setUp(self):
        app.testing = True
        self.client = app.test_client()

    def test_index_page(self):
        response = self.client.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Welcome to the Automated Pipeline Project", response.data)

    def test_process_route(self):
        response = self.client.post('/process', data={'input_text': 'Test'})
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"You entered: Test", response.data)

    def test_process_empty_input(self):
        response = self.client.post('/process', data={'input_text': ''})
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"You didn&#39;t enter anything. Please try again!", response.data)

if __name__ == '__main__':
    unittest.main()
