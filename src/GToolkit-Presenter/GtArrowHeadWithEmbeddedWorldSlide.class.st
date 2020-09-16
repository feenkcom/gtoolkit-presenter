Class {
	#name : #GtArrowHeadWithEmbeddedWorldSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtArrowHeadWithEmbeddedWorldSlide >> create [
	<return: #Object>
	| container curve curveColor headColor headerFillColor curveWidth currentScale |
	
	container := BlParabollaArcElementExamples new relativeCurvatureWithoutDecorations.
	container background: Color transparent.
	container addEventHandler: BlSlideHandler new. 

	curve := container children first.
	
	curveWidth := 40.
	headColor := (Color red alpha: 0.5).
	headerFillColor := (Color gray alpha: 0.2).

	curveColor := (Color gray alpha: 0.5).
	
	curve fromHead:  (BlArrowheadCircle new
		background: BrGlamorousColors defaultHeaderBackgroundColor;
		border: (BlBorder paint: headColor);
		addChild: (BrHorizontalPane new
			alignCenter;
			matchParent;
			padding: (BlInsets all: 20);
			geometry: BlCircle new;
			"addChild: (BrEditor new
				text: 'Hi';
				geometry: BlCircle new;
				look: (BrGlamorousEditorLook new fontSize: 20);
				background: Color white;
				exact: 400@400;
				transformDo: [ :t | t scaleBy: 0.2 ];
				padding: (BlInsets all: 70))))."
			addChild: (GtWorldElement new
				geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
				size: 1100@1100;
				transformDo: [ :t | t scaleBy: 0.01 ]))).
	curve toHead:  (BlArrowheadSimpleArrow new
		background: headColor;
		arrowNoseAngle: 45;
		border: (BlBorder paint: headColor width: 30)).

	curve border: (BlBorder paint: curveColor width: curveWidth).

	currentScale := 1.
	container when: BlClickEvent do: [ :anEvent |
		| aScale |
		
		aScale := anEvent modifiers isShift
			ifTrue: [ (currentScale := (currentScale / 2.0) max: 1) asPoint ]
			ifFalse: [ (currentScale := (currentScale * 2) min: 100) asPoint ]. 

		container addAnimation: (BlTransformAnimation new
			absolute;
			easing: (BlQuinticInterpolator new );
			transformDo: [ :aBuilder | aBuilder
					origin: (BlAffineTransformationPositionOrigin position: anEvent localPosition);
					scaleBy: aScale ]) ].
	
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		clipChildren: false;
		addChild: container;
		yourself
]
