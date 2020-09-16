Class {
	#name : #GtEmptySlide,
	#superclass : #GtLiveSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtEmptySlide >> content [
	^ BlElement new
		background: BlBackground transparent;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
]

{ #category : #accessing }
GtEmptySlide >> create [
	^ BlElement new
		background: BlBackground transparent;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
]
