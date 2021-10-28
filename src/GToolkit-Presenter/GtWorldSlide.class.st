Class {
	#name : #GtWorldSlide,
	#superclass : #GtSlide,
	#category : 'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtWorldSlide >> create [
	<return: #Object>
	^ BlElement new
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent ];
		margin: (BlInsets all: 50);
		background: Color white;
		aptitude: (BrShadowAptitude new width: 6);
		addChild: GtWorldElement new
]
