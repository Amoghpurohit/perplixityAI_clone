from sentence_transformers import SentenceTransformer
from typing import List
import numpy as np
# we firstly convert the input query to a higher dimention query(300-1200 dimentions) and we do the same thing for the 
# response content, and then we take the angle between the 2 vectors and take the cos of it to get the similarity score

class SortSearchService:
    def __init__(self):
        self.embedding_model = SentenceTransformer("all-MiniLM-L6-v2")
    
    # cos @ = Q.R/|Q||R| -> Q-query, R-response
    def query_embedding(self, query: str):
        return self.embedding_model.encode(query, convert_to_tensor=False)
    
    def response_embedding(self, response: List[dict]):
        for result in response:
            result["res_embeddings"] = self.embedding_model.encode(result["content"], convert_to_tensor=False)
            
            
    def cosine_similarity(self, query_embedding, response_embedding):
        #return torch.dot(query_embedding, response_embedding) / (torch.norm(query_embedding) * torch.norm(response_embedding))
        return np.dot(query_embedding, response_embedding) / (np.linalg.norm(query_embedding) * np.linalg.norm(response_embedding))
    
    def sort_search(self, query: str, results: List[dict]):
        # relevant_results = []
        # query_embeddings = self.query_embedding(query)
        # print(len(query_embeddings))
        # self.response_embedding(results)        
    
        # for result in results:
        #     result["similarity_score"] = self.cosine_similarity(query_embeddings, result["res_embeddings"])
        #     if result["similarity_score"] > 0.4:
        #         relevant_results.append(result)

        # return sorted(relevant_results, key=lambda x: x["similarity_score"], reverse=True)
    
        try:
            relevant_docs = []
            query_embedding = self.embedding_model.encode(query)

            for res in results:
                content = res.get("content")
                if not content:
                    continue
                res_embedding = self.embedding_model.encode(content)

                similarity = float(
                    np.dot(query_embedding, res_embedding)
                    / (np.linalg.norm(query_embedding) * np.linalg.norm(res_embedding))
                )

                res["relevance_score"] = similarity

                if similarity > 0.3:
                    relevant_docs.append(res)

            return sorted(
                relevant_docs, key=lambda x: x["relevance_score"], reverse=True
            )
        except Exception as e:
            print(e)

