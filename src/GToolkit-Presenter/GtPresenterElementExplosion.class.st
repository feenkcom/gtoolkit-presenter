Class {
	#name : #GtPresenterElementExplosion,
	#superclass : #Object,
	#instVars : [
		'element',
		'layers'
	],
	#category : #'GToolkit-Presenter-Views'
}

{ #category : #accessing }
GtPresenterElementExplosion >> explode: anElement [
	| scripter elementLayers explosion eachLayerPreview eachLayerLabel extent |
	extent := 900 @ 500.
	scripter := BlScripter new
			extent: extent;
			element: anElement.
	element := scripter elementWithoutParent.

	explosion := BrVerticalPane new fitContent.
	explosion clipChildren: false.
	explosion cellSpacing: 30.

	elementLayers := Stack new.
	elementLayers push: {element}.
	layers
		do: [ :eachLayer | 
			| query |
			query := eachLayer key.
			elementLayers
				push: (elementLayers top flatCollect: [ :each | (query findMany: each) result ]) ].

	eachLayerLabel := Stack new.
	eachLayerLabel push: 'Frame'.
	layers do: [ :eachLayer | eachLayerLabel push: eachLayer value ].

	eachLayerPreview := elementLayers
			with: eachLayerLabel
			collect: [ :anArrayOfElements :eachLabel | 
				| container |
				container := BlElement new
						size: extent;
						constraintsDo: [ :c | c accountTransformation ];
						transformDo: [ :t | t skewX: 35 ];
						addChildren: (anArrayOfElements
								collect: [ :eachElement | 
									| eachPreview |
									eachPreview := eachElement asSpartaForm asElement.
									eachPreview relocate: eachElement positionInSpace.
									eachPreview border: (BlBorder paint: (Color gray alpha: 0.2) width: 2).

									eachElement visibility: BlVisibility hidden.

									eachPreview ]);
						yourself.		"layout: (BlFitChildrenLayout new addLayout: BlBasicNodeBasedLayout new);"
				BrHorizontalPane new
					fitContent;
					alignCenter;
					addChild: (BrFrame new fitContent addChild: container);
					addChild: (BrLabel new
							aptitude: (BrGlamorousLabelAptitude new fontSize: 24);
							text: eachLabel);
					yourself ].

	explosion addChildren: eachLayerPreview.

	^ explosion asScalableElement
]

{ #category : #accessing }
GtPresenterElementExplosion >> initialize [
	super initialize.
	
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
