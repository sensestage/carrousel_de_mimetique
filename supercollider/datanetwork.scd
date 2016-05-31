"pydongui.py".runInTerminal; NetAddr.langPort.postln;

//
OSCFunc.trace( true );

x = SWDataNetwork.new;
s.boot;
x.makeNodeGui;

(
~processing = NetAddr.new( "127.0.0.1", 12000 );
OSCdef( \minibee, { |msg| x.setData(1, [ msg[2] ] ); }, "/minibee/data" );
x.addExpected( 1 );
x.addHook( 1, {
	x.nodes[1].action = MFunc.new;
	x.nodes[1].action.add( \forwardData, { |data| ~processing.sendMsg( "/minibee/data", 1, ~dataSpec.unmap( data[0] ) ); } );

	x.nodes[1].createBus(s);
	~stdNode = StdDevNode.new( 11, x, x.nodes[1].bus, s );
	~stdNode.set(\length,200);
	fork{ 0.2.wait; ~stdNode.start; };
	~meanNode = MeanNode.new( 21, x, x.nodes[1].bus, s );
	~meanNode.set(\length,200);
	fork{ 0.2.wait; ~meanNode.start; };
});


x.addHook( 11, {
	x.nodes[11].action = MFunc.new;
	x.nodes[11].action.add( \forwardData, { |data| ~processing.sendMsg( "/minibee/stddev", 1, ~stdSpec.unmap( data[0] ) ); } );
	// ~leakyNode = LeakyNode.new( 31, x, x.nodes[11].bus, s );
	// ~leakyNode.set(\posSlope1, 0.9, \posSlope2, 0.1, \negSlope, 0.9995 );
	// fork{ 0.2.wait; ~leakyNode.start; };
});

x.addHook( 21, {
	x.nodes[21].action = MFunc.new;
	x.nodes[21].action.add( \forwardData, { |data| ~processing.sendMsg( "/minibee/mean", 1, data[0] ); } );
});

x.addHook( 31, {
	x.nodes[31].action = MFunc.new;
	x.nodes[31].action.add( \forwardData, { |data| ~processing.sendMsg( "/minibee/leaky", 1, data[0] ); } );
});
);


