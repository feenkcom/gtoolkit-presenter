Class {
	#name : #GtBlocSpecialClassHierarchyWithGridSlide,
	#superclass : #GtSlide,
	#category : 'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtBlocSpecialClassHierarchyWithGridSlide >> create [
	<return: #Object>

	^  (GtExamplePreviewStencil new
			example: (GtWhatMakesBlocSpecialExplanation >> #classHierarchyWithGridLayout) gtExample;
			codeExpanded: false;
			previewExpanded: true;
			previewHeight: 300) asElement
				margin: (BlInsets top: 20)
]
