from config import Settings
from tavily import TavilyClient
import trafilatura

settings = Settings()
tavily_client = TavilyClient(api_key=settings.TAVILY_API_KEY)

class SearchService:
    def web_search(self, query: str):
        try:
            results = []
            response = tavily_client.search(query, max_results=5)  #travily for getting the sources
            print("Search Response:", response)  # Better logging
            for result in response["results"]:
                downloaded = trafilatura.fetch_url(result["url"])  # trafilatura for getting the content of the sources
                extracted = trafilatura.extract(downloaded, include_comments=False)
                results.append({
                    "title": result["title"],
                    "url": result["url"],
                    "content": extracted
                })    
            return results
            
        except Exception as e:
            print("Search Error:", str(e))  # Error logging
            return None
