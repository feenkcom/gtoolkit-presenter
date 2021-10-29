"
I am an empty live slide. I don't display anything.


"
Class {
	#name : #GtEmptySlide,
	#superclass : #GtLiveSlide,
	#category : 'GToolkit-Presenter'
}

{ #category : #accessing }
GtEmptySlide >> content [
	^ BlElement new
		background: BlBackground transparent;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
]

{ #category : #'api - instantiation' }
GtEmptySlide >> create [
	^ BlElement new
		background: BlBackground transparent;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
]
