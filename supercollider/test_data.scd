n = NetAddr.new( "127.0.0.1", 12000 );

n.sendMsg( "/minibee/data", 1, 0.4 );

n.sendMsg( "/minibee/stddev", 1, 0.2 );