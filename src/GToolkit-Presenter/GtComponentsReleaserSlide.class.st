Class {
	#name : #GtComponentsReleaserSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtComponentsReleaserSlide >> create [
	| container |
	container := BlElement new
		constraintsDo: [:c |
			c horizontal fitContent.
			c vertical fitContent ];
		layout: (BlGridLayout new columnCount: 4);
		padding: (BlInsets all: 100).
	{'Inspector' . 'Playground' . 'Debugger' . 'Coder' . 'Spotter' . 'Documenter' . 'Presenter' . 'Transcript' . 'Monitor' .
	'Examples' . 'Constrainer' . 'Phlow' . 'Releaser' . 'Visualizer' . 'Completer' .
	'GT4SmaCC' . 'GT4Famix3' . 'GT4PetitParser2' . 'brick' . 'bloc' . 'sparta'} do: [:component | 
		(component = 'Releaser') 
		ifTrue: [ container addChild: (BlTextElement new text: (component asLowercase asRopedText fontName: 'Helvetica Neue'; fontSize: 30; bold); margin: (BlInsets all: 20)) ]; 
		ifFalse: [container addChild: (BlTextElement new text: (component asLowercase asRopedText fontName: 'Helvetica Neue'; fontSize: 30); margin: (BlInsets all: 20))  ]
		 ].
	^ container asPannableElement
]
