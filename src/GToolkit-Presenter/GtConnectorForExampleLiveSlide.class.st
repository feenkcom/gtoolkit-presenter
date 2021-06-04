"
I create a connector example.

{{gtMethod:GtExampleLiveShow>>#connectorExampleSlideFor:|expanded}}


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
