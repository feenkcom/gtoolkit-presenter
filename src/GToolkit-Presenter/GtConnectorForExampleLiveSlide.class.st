"
I am a live slide templates that creates a connector example.

${method:GtExampleLiveShow>>#connectorExampleSlideFor:|expanded}$
"
Class {
	#name : #GtConnectorForExampleLiveSlide,
	#superclass : #GtLiveSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtConnectorForExampleLiveSlide >> create [
	^ ((BlFrameLayoutCompositionExamples>>#example) gtExample gtConnectionsFor: GtPhlowEmptyView new)
		asElementDo: [ :anElement | ^ anElement  ]
]
