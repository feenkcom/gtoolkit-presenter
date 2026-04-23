Class {
	#name : #GtPresenterElementExplosion,
	#superclass : #Object,
	#instVars : [
		'element',
		'layers',
		'baseLabelString',
		'preferredLayerExtent'
	],
	#category : #'GToolkit-Presenter-Views'
}

{ #category : #accessing }
GtPresenterElementExplosion >> baseLabelString [
	^ baseLabelString
]

{ #category : #accessing }
GtPresenterElementExplosion >> baseLabelString: aString [
	baseLabelString := aString
]

{ #category : #accessing }
GtPresenterElementExplosion >> explode: anElement [
	| scripter elementLayers explosion eachLayerPreview eachLayerLabel rootExtent |
	rootExtent := preferredLayerExtent ifNil: [ anElement extent ].
	scripter := BlScripter new
			extent: rootExtent;
			element: anElement.
	element := scripter elementWithoutParent.
	explosion := BrVerticalPane new fitContent.
	explosion clipChildren: false.
	explosion cellSpacing: 0.
	elementLayers := Stack new.
	elementLayers push: {element}.
	layers
		do: [ :eachLayer | 
			| query |
			query := eachLayer key.
			elementLayers
				push: (elementLayers top flatCollect: [ :each | (query findMany: each) result ]) ].
	eachLayerLabel := Stack new.
	eachLayerLabel push: self baseLabelString.
	layers do: [ :eachLayer | eachLayerLabel push: eachLayer value ].
	eachLayerPreview := elementLayers
			with: eachLayerLabel
			collect: [ :anArrayOfElements :eachLabel | 
				| container wrapper |
				container := BlElement new
						size: rootExtent;
						addChildren: (anArrayOfElements
								collect: [ :eachElement | 
									| eachPreview |
									eachPreview := eachElement asSpartaForm asElement.

									eachPreview
										border: (BlBorder paint: (Color veryLightGray alpha: 0.2) width: 4).

									eachElement visibility: BlVisibility hidden.
									eachPreview relocate: eachElement positionInSpace.
									eachPreview ]);
						yourself.
				wrapper := BrHorizontalPane new
						constraintsDo: [ :c | c accountTransformation ];
						transformDo: [ :t | 
							t
								scaleBy: 0.866 @ 0.6;
								shearBy: 0.577 @ 0;
								rotateBy: -30 ];
						fitContent;
						alignCenter;
						addChild: container;
						addChild: (BrFrame new
								fitContent;
								addChild: (BrLabel new
										aptitude: (BrGlamorousLabelAptitude new
												bold;
												fontSize: 50);
										text: eachLabel;
										transformDo: [ :t | t rotateBy: 90 ];
										constraintsDo: [ :c | c accountTransformation ])).
				BrFrame new
					fitContent;
					constraintsDo: [ :c | c accountTransformation ];
					addChild: wrapper ].

	explosion
		addChildren: (eachLayerPreview collectWithIndex: [ :e :index | e zIndex: 0 - index ]).

	^ explosion "asScalableElement"
]

{ #category : #accessing }
GtPresenterElementExplosion >> initialize [
	super initialize.
	baseLabelString := 'Frame'.
	layers := OrderedCollection new
]

{ #category : #accessing }
GtPresenterElementExplosion >> layerQuery: anElementQuery [
	self layerQuery: anElementQuery label: ''
]

{ #category : #accessing }
GtPresenterElementExplosion >> layerQuery: anElementQuery label: aText [
	layers add: (anElementQuery -> aText)
]

{ #category : #accessing }
GtPresenterElementExplosion >> preferredLayerExtent [
	^ preferredLayerExtent
]

{ #category : #accessing }
GtPresenterElementExplosion >> preferredLayerExtent: anObject [
	preferredLayerExtent := anObject
]
