Class {
	#name : #GtLiveSlideExamples,
	#superclass : #Object,
	#category : #'GToolkit-Presenter-Examples'
}

{ #category : #examples }
GtLiveSlideExamples >> slideWithOnAddedToSceneGraphActionEverytime [
	<gtExample>
	| aSlide aCounter anElement |
	
	aSlide := GtProtoLiveSlide new element element: [ BlElement new ].
	aCounter := 0.
	aSlide onEveryAddToSceneGraphDo: [ aCounter := aCounter + 1 ].
	
	anElement := aSlide asElement.

	"adds to scene graph once"
	BlScripter new element: anElement; elementWithoutParent.
	self assert: aCounter equals: 1.
	
	"add it again, make sure action is performed again"
	BlScripter new element: anElement; elementWithoutParent.
	self assert: aCounter equals: 2.
	
	^ anElement
]

{ #category : #examples }
GtLiveSlideExamples >> slideWithOnAddedToSceneGraphActionOnce [
	<gtExample>
	| aSlide aCounter anElement |
	
	aSlide := GtProtoLiveSlide new element element: [ BlElement new ].
	aCounter := 0.
	aSlide onFirstAddToSceneGraphDo: [ aCounter := aCounter + 1 ].
	
	anElement := aSlide asElement.

	"adds to scene graph once"
	BlScripter new element: anElement; elementWithoutParent.
	self assert: aCounter equals: 1.
	
	"add it again, make sure action is not performed"
	BlScripter new element: anElement; elementWithoutParent.
	self assert: aCounter equals: 1.
	
	^ anElement
]
