Class {
	#name : #GtPresenterSlideViewModelRemovedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'slideViewModel'
	],
	#category : #'GToolkit-Presenter-View Models - Events'
}

{ #category : #generated }
GtPresenterSlideViewModelRemovedAnnouncement >> slideViewModel [
	<objectGetter: #slide>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ slideViewModel
]

{ #category : #generated }
GtPresenterSlideViewModelRemovedAnnouncement >> slideViewModel: aSlideViewModel [
	<objectSetter: #slide>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	slideViewModel := aSlideViewModel
]
