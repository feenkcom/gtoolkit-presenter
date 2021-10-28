Class {
	#name : #GtSlideShowElement,
	#superclass : #BlElement,
	#instVars : [
		'slideShow'
	],
	#category : 'GToolkit-Presenter'
}

{ #category : #'hooks - children' }
GtSlideShowElement >> onAddedToSceneGraph [

	super onAddedToSceneGraph.
	self slideShow onAddedToSceneGraph: self space
]

{ #category : #accessing }
GtSlideShowElement >> slideShow [
	^ slideShow
]

{ #category : #accessing }
GtSlideShowElement >> slideShow: anObject [
	slideShow := anObject
]
