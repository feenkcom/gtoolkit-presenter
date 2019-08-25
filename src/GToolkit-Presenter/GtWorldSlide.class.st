Class {
	#name : #GtWorldSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtWorldSlide >> create [
	<return: #Object>
	^ BlElement new
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent ];
		margin: (BlInsets all: 10);
		background: Color white;
		look: BrShadowLook;
		addChild: GtWorldElement new
]
