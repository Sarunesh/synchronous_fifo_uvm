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
`define CONNECT_IF_NOT_NULL(src,dst) \
	if(src!=null && dst!=null) \
		src.connect(dst); \
	else \
		`uvm_warning("NULL_CONNECT",$sformatf("!!!! Connection failed: %0s or %0s is null",`"src`",`"dst`"))
`endif
