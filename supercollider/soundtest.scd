Ndef( \sound, { SinOsc.ar( \freq.kr(500) * SinOsc.ar( \ffreq.kr(10), 0, \fmul.kr(0.1), 1 ), 0, \amp.kr(0.1, 0.1) ) } ).play;

Ndef( \sound ).addSpec( \freq, [400, 1000, \exp] );
Ndef( \sound ).addSpec( \amp, [0.001, 0.5, \exp ] );
Ndef( \sound ).addSpec( \ffreq, [40, 300, \exp ] );
Ndef( \sound ).addSpec( \fmul, [0.05, 0.5, \exp ] );

// ~freqSpec = [300, 3000, \exp].asSpec;
// ~ampSpec = [ 0.05, 0.5, \exp].asSpec;
// ~ffreqSpec = [40, 300, \exp].asSpec;
// ~fmulSpec = [0.05, 0.5, \exp].asSpec;

~dataSpec = [ 0.16, 0.09 ].asSpec;
~stdSpec = [ 0.001, 0.03, \exp ].asSpec;

(
x.nodes[1].action.add( \sound, { |data|
	Ndef( \sound ).setUni( \freq, ~dataSpec.unmap( data[0] ) );
	Ndef( \sound ).setUni( \ffreq, ~dataSpec.unmap( data[0] ) );
	// Ndef( \sound ).set( \freq, data[0].specMap( ~dataSpec, ~freqSpec ) );
	// Ndef( \sound ).set( \ffreq, data[0].specMap( ~dataSpec, ~ffreqSpec ) );
});
);
(
x.nodes[11].action.add( \sound, { |data|
	Ndef( \sound ).setUni( \amp, ~stdSpec.unmap( data[0] ) );
	Ndef( \sound ).setUni( \fmul, ~stdSpec.unmap( data[0] ) );
	// Ndef( \sound ).set( \amp, ~ampSpec.map( data[0] ) );
	// Ndef( \sound ).set( \fmul, data[0].specMap( ~stdSpec, ~fmulSpec ) );
})
);