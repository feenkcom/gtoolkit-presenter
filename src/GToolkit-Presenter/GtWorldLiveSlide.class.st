"
I create a world element and display it.

${method:GtExampleLiveShow>>#worldExampleSlideFor:|expanded=}$
"
Class {
	#name : #GtWorldLiveSlide,
	#superclass : #GtLiveSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtWorldLiveSlide >> create [
	<return: #Object>
	^ BlElement new
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent ];
		margin: (BlInsets all: 50);
		background: Color white;
		look: (BrShadowLook new width: 6);
		addChild: GtWorldElement new
]
