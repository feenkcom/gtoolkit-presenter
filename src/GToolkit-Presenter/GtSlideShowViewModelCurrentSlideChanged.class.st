Class {
	#name : #GtSlideShowViewModelCurrentSlideChanged,
	#superclass : #Announcement,
	#instVars : [
		'currentSlide'
	],
	#category : #'GToolkit-Presenter-View Models - Events'
}

{ #category : #generated }
GtSlideShowViewModelCurrentSlideChanged >> currentSlide [
	<objectGetter: #slideShow>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ currentSlide
]

{ #category : #generated }
GtSlideShowViewModelCurrentSlideChanged >> currentSlide: aCurrentSlide [
	<objectSetter: #slideShow>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	currentSlide := aCurrentSlide
]
