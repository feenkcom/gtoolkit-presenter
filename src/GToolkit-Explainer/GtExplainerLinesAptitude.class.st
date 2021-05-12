Class {
	#name : #GtExplainerLinesAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'isForTarget',
		'addedLines'
	],
	#category : #'GToolkit-Explainer'
}

{ #category : #private }
GtExplainerLinesAptitude >> allChildrenWithSameExplanationModel: aWidget do: aBlock [
	isForTarget
		ifFalse: [
			aWidget explainer firstExplanationHolderParent explainer
				allTargetChildrenWithModel: aWidget explainer model
				do: aBlock ]
		ifTrue: [
			aWidget explainer firstExplanationHolderParent explainer
				allExplanationChildrenWithModel: aWidget explainer model
				do: aBlock ]
]

{ #category : #accessing }
GtExplainerLinesAptitude >> beForExplanation [
	isForTarget := false
]

{ #category : #accessing }
GtExplainerLinesAptitude >> beForTarget [
	isForTarget := true
]

{ #category : #initialization }
GtExplainerLinesAptitude >> initialize [
	super initialize.
	
	addedLines := OrderedCollection new.
	isForTarget := true
]

{ #category : #initialization }
GtExplainerLinesAptitude >> initializeListeners [
	super initializeListeners.
	
	self when: BlElementHoveredEvent do: [ :anEvent | self onHovered: anEvent element ].
	self when: BlElementUnhoveredEvent do: [ :anEvent | self onUnhovered: anEvent element ].
]

{ #category : #initialization }
GtExplainerLinesAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.

	anElement states withHover
]

{ #category : #private }
GtExplainerLinesAptitude >> onHovered: aWidget [
	self
		allChildrenWithSameExplanationModel: aWidget
		do: [ :explanationTargetElement | 
			| aNewLine |
			aNewLine := BlLineElement new
				fromAnchor:
					(BlNearestPositionTightCircleAnchor
						referenceElement: aWidget
						relatedTo: explanationTargetElement);
				toAnchor:
					(BlNearestPositionTightCircleAnchor
						referenceElement: explanationTargetElement
						relatedTo: aWidget);
				zIndex: 10;
				border:
					(BlBorder
						paint: (self theme button textHighlightColor alpha: 0.7)
						width: 2);
				constraintsDo: [ :c | c ignoreByLayout ];
				yourself.
			aWidget
				firstCommonParent: explanationTargetElement
				ifFound: [ :aCommonParent | 
					addedLines add: aNewLine.
					aCommonParent addChild: aNewLine.
					explanationTargetElement
						dispatchEvent: GtExplanationLinkConnectedEvent new ]
				ifNone: [  ] ]
]

{ #category : #private }
GtExplainerLinesAptitude >> onUnhovered: anElement [
	addedLines do: [ :eachLine |
		eachLine removeFromParent.
		eachLine toAnchor referenceElement fireEvent: GtExplanationLinkDisconnectedEvent new ].
	addedLines removeAll
]
