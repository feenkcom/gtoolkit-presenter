Class {
	#name : #GtBlocSpecialClassHierarchyWithEdgesAndLinesSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtBlocSpecialClassHierarchyWithEdgesAndLinesSlide >> create [
	<return: #Object>

	^  (GtExamplePreviewStencil new
			example: (GtWhatMakesBlocSpecialExplanation >> #classHierarchyWithEdgesAndLines) gtExample;
			codeExpanded: false;
			previewExpanded: true;
			previewHeight: 500) asElement
				margin: (BlInsets top: 20)
]
