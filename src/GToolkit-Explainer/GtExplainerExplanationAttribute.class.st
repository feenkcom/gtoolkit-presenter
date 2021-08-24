Class {
	#name : 'GtExplainerExplanationAttribute',
	#superclass : 'BrTextAdornmentAttribute',
	#instVars : [
		'explanationModel'
	],
	#category : 'GToolkit-Explainer'
}

{ #category : 'accessing' }
GtExplainerExplanationAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| aTextPieceElement |

	aTextPieceElement := (BrTextEditableWordPieceStencilBuilder new
		shouldUsePool: false;
		segmentPiece: aTBrTextEditorTextualPiece) asElement.

	aTextPieceElement
		aptitude: (GtExplainerExplanationAptitude new explanationModel: self explanationModel) + GtExplainerExplanationAttributeAptitude;
		clipChildren: false;
		layout: BlLinearLayout vertical;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		padding: (BlInsets left: 4 right: 4);
		constraintsDo: [ :c | c textFlow doNotFillLine ].
	
	^ aTextPieceElement
]

{ #category : 'accessing' }
GtExplainerExplanationAttribute >> explanationModel [
	^ explanationModel
]

{ #category : 'accessing' }
GtExplainerExplanationAttribute >> explanationModel: anObject [
	explanationModel := anObject
]
