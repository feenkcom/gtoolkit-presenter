"
I create a world element and display it.

{{gtMethod:GtExampleLiveShow>>#worldExampleSlideFor:|expanded=}}


"
Class {
	#name : #GtWorldLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'knowledgeBase'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtWorldLiveSlide >> create [
	<return: #Object>
	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		margin: (BlInsets all: 50);
		background: Color white;
		aptitude: (BrShadowAptitude new width: 6);
		addChild: (GtWorldElement new knowledgeBase: knowledgeBase)
]

{ #category : #accessing }
GtWorldLiveSlide >> initialize [
	super initialize.
	knowledgeBase := LeDatabasesRegistry uniqueInstance currentLoadedDefaultLogicalDatabase
]

{ #category : #accessing }
GtWorldLiveSlide >> knowledgeBase [
	^ knowledgeBase
]

{ #category : #accessing }
GtWorldLiveSlide >> knowledgeBase: anObject [
	knowledgeBase := anObject
]
