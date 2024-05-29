Class {
	#name : #GtPresenterExplosionElement,
	#superclass : #BlElement,
	#instVars : [
		'element',
		'layers'
	],
	#category : #'GToolkit-Presenter-Views'
}

{ #category : #accessing }
GtPresenterExplosionElement >> explode: anElement [
	| scripter elementLayers explosion eachLayerPreview eachLayerLabel |
	
	scripter := BlScripter new
		extent: 900@500;
		element: anElement.
	element := scripter elementWithoutParent.
	
	explosion := BrVerticalPane new fitContent.
	explosion clipChildren: false.
	explosion cellSpacing: 30.
	
	elementLayers := Stack new.
	elementLayers push: { element }.
	layers do: [ :eachLayer |
		| query |
		query := eachLayer key.	
		elementLayers push: (elementLayers top flatCollect: [ :each | (query findMany: each) result ]) ].

	eachLayerLabel := Stack new.
	eachLayerLabel push: 'Frame'.
	layers do: [ :eachLayer | eachLayerLabel push: eachLayer value ].
	
	eachLayerPreview := elementLayers with: eachLayerLabel collect: [ :anArrayOfElements :eachLabel |
		| container |
		container := BlElement new
			transformDo: [ :t | t skewX: 35 ];
			layout: (BlFitChildrenLayout new addLayout: BlBasicNodeBasedLayout new);
			constraintsDo: [ :c |
				c accountTransformation .
				c horizontal fitContent .
				c vertical fitContent ];
			addChildren: (anArrayOfElements collect: [ :eachElement |
				| eachPreview |
				
				eachPreview := eachElement asSpartaForm asElement.
				eachPreview relocate: eachElement positionInSpace.
				eachPreview border: (BlBorder paint: (Color gray alpha: 0.2) width: 2).
				
				eachElement visibility: BlVisibility hidden.
				
				eachPreview ]);
			yourself.
		
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
GtPresenterExplosionElement >> initialize [
	super initialize.
	
	layers := OrderedCollection new
]

{ #category : #accessing }
GtPresenterExplosionElement >> layerQuery: anElementQuery [
	self layerQuery: anElementQuery label: ''
]

{ #category : #accessing }
GtPresenterExplosionElement >> layerQuery: anElementQuery label: aText [
	layers add: (anElementQuery -> aText)
]
