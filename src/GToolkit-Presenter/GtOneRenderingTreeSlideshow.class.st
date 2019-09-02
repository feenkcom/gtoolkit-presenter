Class {
	#name : #GtOneRenderingTreeSlideshow,
	#superclass : #GtSlideShow,
	#category : #'GToolkit-Presenter'
}

{ #category : #initialization }
GtOneRenderingTreeSlideshow >> initialize [
	super initialize.
	
	self slides: { 
		GtTitleSlide new
            titleText: ('one rendering tree' asRopedText 
                fontSize: 90;
					fontName: 'Helvetica Neue';
					bold;
                yourself).

	GtTitleSlide new
            titleText: ('feenk' asRopedText 
                fontSize: 90; fontName: 'Helvetica Neue'; bold;
                in: [:title | (title from: 1 to: 3) fontName: 'Desyrel'; fontSize: 110];
                yourself).

	GtEditorElementWithRotatedWords new.
	GtEditorElementWithTreeSlide new.
	GtEditorElementWithDebugCharacterSlide new.

	GtSearchFilterHierarchySlide new.
	GtConnectorForExampleSlide new.
	
	GtOneRenderingTreeRopeVisualisationSlide new.
	
	GtBlocSpecialClassHierarchyWithGridSlide new.
	GtBlocSpecialClassHierarchyWithEdgesSlide new.
	GtBlocSpecialClassHierarchyWithEdgesAndLinesSlide new.
	
	GtArrowHeadWithEmbeddedWorldSlide new.
	
	GtTitleSlide new
		titleText: ('gtoolkit.com' asRopedText 
		fontSize: 90; fontName: 'Helvetica Neue'; bold)
	}
]
