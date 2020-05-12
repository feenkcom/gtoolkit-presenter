Class {
	#name : #GtEditorDiffSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtEditorDiffSlide >> create [
	<return: #Object>

	 | model rewriter |
	 model := RBNamespace new.
	 rewriter := RBParseTreeRewriter new.
	 rewriter replace: '``@a isNil ifTrue: ``@b' with: '``@a ifNil: ``@b'.
	 model allReferencesTo: #isNil do: [:method |
	     (rewriter executeTree: method ast) ifTrue: [method compileTree: rewriter tree
	 ]].
	 ^ Gt2Inspector createOn: model changes
]
