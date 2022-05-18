Class {
	#name : #GtPresenterSlideShowViewModelCurrentSlideChanged,
	#superclass : #Announcement,
	#instVars : [
		'currentSlide'
	],
	#category : #'GToolkit-Presenter-View Models - Events'
}

{ #category : #generated }
GtPresenterSlideShowViewModelCurrentSlideChanged >> currentSlide [
	<objectGetter: #slideShow>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ currentSlide
]

{ #category : #generated }
GtPresenterSlideShowViewModelCurrentSlideChanged >> currentSlide: aCurrentSlide [
	<objectSetter: #slideShow>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	currentSlide := aCurrentSlide
]
