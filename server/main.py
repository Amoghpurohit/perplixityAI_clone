from fastapi import FastAPI, WebSocket
from pydantic_models.chat_body import ChatBody
from services.llm_service import LLM_service
from services.search_service import SearchService
from services.sort_search_service import SortSearchService

app = FastAPI()

search_service = SearchService()
sort_search_service = SortSearchService()
llM_service = LLM_service()

@app.websocket("/ws/chat")
async def websocket_chat_endpoint(websocket: WebSocket):
    await websocket.accept()
    
    data = await websocket.receive_json()
    query = data.get("query")
    
    result = search_service.web_search(query)
    sorted_results = sort_search_service.sort_search(query, result)
    await websocket.send_json({"query":query, "type":"search_result", "results":sorted_results})
    
    for chunk in llM_service.generate_response(query, sorted_results):
        # await asyncio.sleep(0.1)
        await websocket.send_json({"type":"LLM response", "response":chunk})
    #response = llM_service.generate_response(query, sorted_results)

@app.post("/chat")
def chat_endPoint(body: ChatBody):
    # search_service = SearchService()
    # sort_search_service = SortSearchService()
    # llM_service = LLM_service()
    result = search_service.web_search(body.query)
    sorted_results = sort_search_service.sort_search(body.query, result)
    response = llM_service.generate_response(body.query, sorted_results)
    print("Main Result:", sorted_results)
    return {"query": body.query, "response": response}
