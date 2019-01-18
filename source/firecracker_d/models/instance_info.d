module firecracker_d.models.instance_info;
import jsonizer;
import firecracker_d.models.base_model;

struct InstanceInfo {
	mixin JsonizeMe;
	mixin BaseModel;

	/***
	*  Possible states that our microVM could be in
	***/
	enum InstanceState : string {
		Uninitialized = "Uninitialized",
		Starting = "Starting",
		Running = "Running",
		Halting = "Halting",
		Halted = "Halted"
	}

	/***
	* ID of our current microVM
	***/
	@jsonize("id", Jsonize.opt) string id;

	/***
	* State of our current microVM
	***/
	@jsonize("state", Jsonize.opt) InstanceState state;

	this(FirecrackerAPIClient cl) {
		Response r = cl.get("/");

		if(r.code == 200) {
			InstanceInfo k = r.responseBody.toString.parseJSON.fromJSON!InstanceInfo;
			this = k;
		}
		else {
			throwFromResponse(r);
		}
	}

}
