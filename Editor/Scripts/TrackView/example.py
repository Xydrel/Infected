'''
This example script prints info of all TrackView sequences
'''

numTracks = trackview.get_num_sequences()

for i in range(numTracks):
	print "Sequence '", trackview.get_sequence_name(i), "':"