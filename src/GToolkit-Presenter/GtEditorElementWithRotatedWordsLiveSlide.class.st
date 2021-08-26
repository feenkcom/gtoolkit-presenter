"
I show an editor element with three buttons that can alter the look of the editor.

{{gtMethod:GtExampleLiveShow>>#editorElementWithRotatedWordsExampleSlideFor:|expanded=}}


"
Class {
	#name : 'GtEditorElementWithRotatedWordsLiveSlide',
	#superclass : 'GtEditorElementLiveSlide',
	#category : 'GToolkit-Presenter'
}

{ #category : 'api - instantiation' }
GtEditorElementWithRotatedWordsLiveSlide >> create [
	<return: #Object>
	| aContainer anEditor theButtons |

	aContainer := BrHorizontalPane new
		matchParent;
		alignCenter.
		
	theButtons := BrVerticalPane new
		fitContent;
		margin: (BlInsets left: 10).

	anEditor := BrEditor new
		aptitude: (BrGlamorousRegularEditorAptitude new fontSize: 30);
		vFitContent;
		hExact: 600;
		text: ('Glamorous Toolkit is the moldable development environment. It is a live notebook. It is a flexible search interface. It is a fancy code editor. It is a software analysis platform. It is a data visualization engine. All in one. It is built in Pharo and it is free and open-source under an MIT license.').
		
	aContainer addChild: anEditor.
	aContainer addChild: theButtons.
	
	theButtons addChild: (BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude;
		label: 'Paint';
		margin: (BlInsets all: 5);
		action: [ anEditor childrenDo: [ :eachSegment |
			eachSegment childrenDo: [ :eachWord |
				eachWord text foreground: Color random.
				eachWord textChanged ] ] ]).
	
	theButtons addChild: (BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude;
		label: 'Resize';
		margin: (BlInsets all: 5);
		action: [ anEditor childrenDo: [ :eachSegment |
			eachSegment childrenDo: [ :eachWord |
				eachWord text fontSize: (24 to: 38) atRandom.
				eachWord textChanged ] ] ]).
	
	theButtons addChild: (BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude;
		label: 'Rotate';
		margin: (BlInsets all: 5);
		action: [ anEditor childrenDo: [ :eachSegment |
			eachSegment childrenDo: [ :eachWord |
				eachWord transformDo: [ :t | t rotateBy: (-10 to: 10) atRandom ] ] ] ]).
	
	^ aContainer
]
