
from pydantic import BaseModel

class ChatBody(BaseModel):
    query: str
    


# here inside the chatBody class, im basically defining the structure the request body also their types and then using 
# BaseModel to have all the serialization and type safety along with it,

# so now we have a way to define the structure of the request body and also have type safety and serialization
