Class {
	#name : #GtBlocSpecialClassHierarchyWithEdgesSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtBlocSpecialClassHierarchyWithEdgesSlide >> create [
	<return: #Object>

	^  (GtExamplePreviewStencil new
			example: (GtWhatMakesBlocSpecialExplanation >> #classHierarchyWithEdges) gtExample;
			codeExpanded: false;
			previewExpanded: true;
			previewHeight: 500) asElement
				margin: (BlInsets top: 20)
]
