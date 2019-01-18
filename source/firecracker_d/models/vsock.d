module firecracker_d.models.vsock;
import jsonizer;
import firecracker_d.models.base_model;

struct Vsock {
	mixin JsonizeMe;
	mixin BaseModel;

	/*
	   This enables local communication to occur between a 
	   microVM, and the host, by creating a socket on both
	   the host, as well as the guest. 
	   Read more here: http://man7.org/linux/man-pages/man7/vsock.7.html
	*/

	// The guest's Context Identifier
	@jsonize("guest_cid", Jsonize.opt) long guestCid;

	@jsonize("id", Jsonize.yes) string id;

	bool put(FirecrackerAPIClient cl) {
		Response r = cl.put("/vsocks/" ~ id, this.toString);

		if(r.code == 201 || r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}
	}

}