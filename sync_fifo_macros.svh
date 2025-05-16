`ifndef NEW_COMPONENT
//Macro for component class constructor
`define NEW_COMPONENT \
	function new(string name="",uvm_component parent=null); \
		super.new(name,parent); \
	endfunction
`endif

`ifndef NEW_OBJECT
//Macro for object class constructor
`define NEW_OBJECT \
	function new(string name=""); \
		super.new(name); \
	endfunction
`endif

`ifndef CONNECT_IF_NOT_NULL
`define CONNECT_IF_NOT_NULL(src,dst)													\
	if(src!=null && dst!=null)															\
		src.connect(dst);																\
	else begin																			\
		if(!src && !dst)																\
			`uvm_warning("NULL_CONNECT",$sformatf("!!!! Connection failed: %0s and %0s are null",`"src`",`"dst`"))																	   \
		else if(!src && dst)															\
			`uvm_warning("NULL_CONNECT",$sformatf("!!!! Connection failed: %0s is null",`"src`"))																					   \
		else																			\
			`uvm_warning("NULL_CONNECT",$sformatf("!!!! Connection failed: %0s is null",`"dst`"))																					   \
	end
`endif

`ifndef UVM_NULL_CHECK
`define UVM_NULL_CHECK(HANDLE, CONTEXT) \
    if (!(HANDLE)) begin \
        `uvm_error(CONTEXT, `"!!!! HANDLE is null !!!!`") \
    end else begin \
        `uvm_info(CONTEXT, $sformatf(">>>> %0t Created: %0s <<<<", $time, `"HANDLE`"), UVM_DEBUG) \
    end
`endif
