import google.generativeai as genai
from config import Settings

settings = Settings()

class LLM_service:
    
    def __init__(self):
        genai.configure(api_key=settings.GEMINI_API_KEY)
        self.model = genai.GenerativeModel(
            model_name="gemini-2.0-flash-exp",)
    
    def generate_response(self, query: str, results: list[dict]):
        # stuff that we will be passing to the LLM
        
        context_text = "\n\n".join([f"Source {i+1} :{result['url']}\nContent: {result['content']}" for i, result in enumerate(results)])
        
        
        full_prompt = f"""
        Context from web search:
        {context_text}
        User query:
        {query}
        Please provide a comprehensive, detailed and well-cited accurate answer to the user's query based on the provided context.Think and reason deeply.Do not use your own knowledge unless its absolutely necessary.
        """
        
        response = self.model.generate_content(full_prompt, stream=True)  # stream=True is used to stream the response in chunks
         
        for chunk in response:
            yield chunk.text        #yield is used to return a value from a function without exiting the function
