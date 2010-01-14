package ruby;

import javax.ws.rs.*;

@Path("/helloworld")
public class HelloWorldResource {
    @GET
    @Produces("text/plain")
    public String getMessage() {
        return "Hello World";
    }

    @GET
    @Produces("text/plain")
    @Path("{id}")
    public String getPersonalMessage(@PathParam("id") String message) {
        return "Hello " + message;
    }
}